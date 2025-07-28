import json
import os
import time
from flask import Flask, request, jsonify
from langchain_community.vectorstores import FAISS
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain.chains import RetrievalQA
from langchain_community.llms import HuggingFacePipeline
from langchain.schema import Document
from langchain.text_splitter import RecursiveCharacterTextSplitter
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM, pipeline
import shutil

# -----------------------------
# 1. Load Q&A Datasets
# -----------------------------
def load_qa_datasets():
    files = [
        "egypt_historical_places.json",
        "egypt_tourism_and_historical_sites.json"
    ]
    documents = []
    for file in files:
        if not os.path.exists(file):
            print(f"⚠️ File not found: {file}")
            continue
        with open(file, "r", encoding="utf-8") as f:
            data = json.load(f)
        if isinstance(data, list):
            for item in data:
                q = item.get("question")
                a = item.get("answer")
                if q and a:
                    documents.append(Document(page_content=f"Q: {q}\nA: {a}"))
        elif isinstance(data, dict) and "question" in data and "answer" in data:
            for q, a in zip(data["question"], data["answer"]):
                documents.append(Document(page_content=f"Q: {q}\nA: {a}"))
    return documents

# -----------------------------
# 2. Load City/Place Dataset
# -----------------------------
def load_city_recommendations(file_path="egypt_historical_places.json"):
    if not os.path.exists(file_path):
        print(f"⚠️ File not found: {file_path}")
        return []
    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    documents = []
    for entry in data:
        city = entry.get("city")
        places = entry.get("places", [])
        if city and places:
            content = f"City: {city}\nRecommended Historical Places:\n" + "\n".join(f"- {p}" for p in places)
            documents.append(Document(page_content=content))
    return documents

# -----------------------------
# 3. Load and Split All Docs
# -----------------------------
def load_all_documents():
    qa_docs = load_qa_datasets()
    city_docs = load_city_recommendations()
    return qa_docs + city_docs

def split_documents(docs):
    splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=90)
    return splitter.split_documents(docs)

# -----------------------------
# 4. FAISS Vector Store
# -----------------------------
def create_or_load_vectorstore(split_docs, embeddings, index_path="faiss_index"):
    index_file = f"{index_path}/index.faiss"
    if os.path.exists(index_file):
        try:
            print("📥 Loading existing FAISS index...")
            return FAISS.load_local(index_path, embeddings, allow_dangerous_deserialization=True)
        except AssertionError:
            print("❌ FAISS index incompatible. Rebuilding...")
            shutil.rmtree(index_path, ignore_errors=True)

    print("📦 Creating new FAISS index...")
    vectorstore = FAISS.from_documents(split_docs, embeddings)
    vectorstore.save_local(index_path)
    return vectorstore

# -----------------------------
# 5. Load Fast + Accurate LLM
# -----------------------------
def load_local_llm(model_id="declare-lab/flan-alpaca-base"):
    print(f"⚡ Loading local model: {model_id}")
    tokenizer = AutoTokenizer.from_pretrained(model_id)
    model = AutoModelForSeq2SeqLM.from_pretrained(model_id)
    pipe = pipeline(
        "text2text-generation",
        model=model,
        tokenizer=tokenizer,
        max_new_tokens=128,
        #temperature=0.3,
        #top_p=0.95,
        repetition_penalty=1.2,
    )
    return HuggingFacePipeline(pipeline=pipe)

# -----------------------------
# 6. Initialize Chatbot
# -----------------------------
def initialize_chatbot():
    print("📄 Loading documents...")
    raw_docs = load_all_documents()
    split_docs = split_documents(raw_docs)

    print("📚 Loading vectorstore...")
    embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-mpnet-base-v2")
    vectorstore = create_or_load_vectorstore(split_docs, embeddings)

    print("🤖 Loading local language model...")
    llm = load_local_llm()

    qa = RetrievalQA.from_chain_type(
        llm=llm,
        retriever=vectorstore.as_retriever(search_kwargs={"k": 7}),
        return_source_documents=False
    )
    return qa

# -----------------------------
# 7. Flask API Setup
# -----------------------------
app = Flask(__name__)
qa_chain = initialize_chatbot()

@app.route("/")
def root():
    return jsonify({"message": "✅ Egypt Chatbot API is running!"})

@app.route("/chat", methods=["POST"])
def chat():
    data = request.get_json()
    query = data.get("question")
    if not query:
        return jsonify({"error": "Missing 'question' in request."}), 400

    start_time = time.time()
    try:
        result = qa_chain.invoke({"query": query})
    except Exception as e:
        return jsonify({"error": "Internal Server Error", "details": str(e)}), 500
    end_time = time.time()

    return jsonify({
        "answer": result["result"],
        "response_time_sec": round(end_time - start_time, 2)
    })

# -----------------------------
# 8. Run the App
# -----------------------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=1234)
