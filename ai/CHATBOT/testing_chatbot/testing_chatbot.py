import json
import requests
import os

API_URL = "http://localhost:1234/chat"

# ----------------------------------------
# 1. Auto-create test_questions.json
# ----------------------------------------
if not os.path.exists("test_questions.json"):
    print("📄 Creating test_questions.json...")
    questions = [{"question": q} for q in [
        "What are the top historical sites to visit in Cairo?",
        "Can I go inside the Great Pyramid of Giza?",
        "What is the best way to explore the Valley of the Kings?",
        "Are guided tours available at Abu Simbel?",
        "What can I expect to see at the Karnak Temple?",
        "Is it possible to visit the Sphinx up close?",
        "What’s special about the Temple of Hatshepsut?",
        "How long should I spend at Luxor Temple?",
        "Can I visit Tutankhamun’s tomb?",
        "What’s the difference between the Red and Bent Pyramids?",
        "Are there any restrictions at the Saqqara site?",
        "What are the best times to visit the Giza Plateau?",
        "Is the Egyptian Museum in Cairo worth visiting?",
        "What’s inside the new Grand Egyptian Museum?",
        "How do I get to Philae Temple from Aswan?",
        "What are the highlights of Old Cairo?",
        "Where is the Hanging Church and can tourists enter?",
        "What is the best way to reach the Temple of Edfu?",
        "What’s special about Kom Ombo Temple?",
        "What are the best Nile cruise routes for history lovers?",
        "How can I visit the Colossi of Memnon?",
        "Are there any tombs open to the public in the Valley of the Queens?",
        "Can I see hieroglyphics at Dendera Temple?",
        "Is Saint Catherine’s Monastery open to tourists?",
        "What are the must-see attractions in Alexandria?",
        "Where is Pompey's Pillar and why is it famous?",
        "Can tourists visit the Roman Amphitheatre in Alexandria?",
        "What’s the history behind the Citadel of Saladin?",
        "What’s the best way to visit the Coptic Museum?",
        "Is the Abu Simbel light show worth seeing?",
        "Are there any temples on Elephantine Island?",
        "What ruins can I see near Fayoum?",
        "Where is the Serapeum of Saqqara?",
        "Can I walk around the Temple of Esna?",
        "What are the Medinet Habu temples?",
        "Are there day trips to Tanis from Cairo?",
        "What should I know before visiting the Nubian Museum?",
        "What’s special about the Temple of Kalabsha?",
        "Can I visit the Tomb of Nefertari?",
        "Is photography allowed at the pyramids?",
        "Are tickets required for each site or is there a pass?",
        "What’s the best way to plan an Egypt history tour?",
        "Can I hire a private guide for ancient sites?",
        "How much time do I need to see Abu Simbel?",
        "Is the White Desert a historical site or natural wonder?",
        "What is unique about Tell el-Amarna?",
        "Can tourists visit ancient temples in Sinai?",
        "Are there historic mosques worth visiting in Cairo?",
        "What is Islamic Cairo and what can I see there?",
        "How do I get to the Monastery of Saint Anthony?",
        "What is the significance of the Mosque of Ibn Tulun?",
        "Is there a historical site at Rosetta?",
        "What can I see in Al-Qasr village in Dakhla Oasis?",
        "What should I know about Deir el-Medina?",
        "Is the Temple of Seti I in Abydos open to visitors?",
        "What is the easiest way to get from Cairo to Luxor?",
        "Can I see real mummies in museums in Egypt?",
        "Are there boat tours to historical temples along the Nile?",
        "What safety tips should I follow while visiting ancient sites?",
        "What is the cost to enter the Valley of the Kings?",
        "What is unique about the Tombs of the Nobles in Aswan?",
        "How can I access the ruins in Heliopolis?",
        "What historical places are there in Minya?",
        "Are there any Greco-Roman sites in Egypt?",
        "What ancient ruins are underwater in Alexandria?",
        "How accessible are the Giza pyramids for seniors?",
        "Can I visit temples at sunrise or sunset?",
        "What is the best itinerary for a historical Egypt trip?",
        "Where can I see temples with original colors preserved?",
        "Can I explore pyramid tunnels or chambers?",
        "What are the best temples for photos?",
        "Is it safe to travel alone to historical sites?",
        "What local foods can I try near historical places?",
        "Can I rent audio guides at archaeological sites?",
        "How do I book tickets to the Grand Egyptian Museum?",
        "Are there official tour guides at sites like Karnak?",
        "What is the story behind the Unfinished Obelisk?",
        "Is Al-Azhar Mosque a tourist site?",
        "What are the main historical places in Islamic Cairo?",
        "Where are Cleopatra’s ruins believed to be?",
        "What’s the history behind Bab Zuweila?",
        "Is Al-Muizz Street open to tourists?",
        "What’s the best view of the pyramids at sunset?",
        "How do I get from Luxor to Aswan for temple visits?",
        "Can tourists visit Qaitbay Citadel in Alexandria?",
        "Is there a dress code for visiting historical places?",
        "Where can I see Roman ruins in Egypt?",
        "How hot does it get at major ancient sites?",
        "What’s the best way to combine Red Sea and history tours?",
        "Are there historical sites near Sharm El Sheikh?",
        "Is camping allowed near historical monuments?",
        "What apps help with visiting historical Egypt?",
        "Are any temples open at night?",
        "What are lesser-known sites that tourists miss?",
        "What’s the historical significance of the Nile cruise stops?",
        "What temples are still being excavated?",
        "Can I see actual tools used by ancient builders?",
        "How to avoid tourist crowds at popular historical sites?",
        "Where are Egypt’s oldest ruins?",
        "Which temples have zodiac ceilings or astronomical art?",
        "Are there any interactive exhibits in Egypt museums?",
        "What language did ancient Egyptians speak?",
        "What is the Rosetta Stone and why is it important?",
        "What were hieroglyphs used for?",
        "How did ancient Egyptians preserve bodies?",
        "What are canopic jars and what were they used for?",
        "What was daily life like in ancient Egypt?",
        "What tools did ancient Egyptians use in construction?",
        "Who were the most powerful pharaohs?",
        "How did Cleopatra die?",
        "What was the capital of ancient Egypt during the Old Kingdom?",
        "What was the role of priests in Egyptian temples?",
        "What crops were grown along the Nile?",
        "What did ancient Egyptian houses look like?",
        "What was the purpose of obelisks?",
        "Who were the Hyksos and how did they impact Egypt?",
        "What was the significance of Akhenaten’s reign?",
        "Who was Nefertiti?",
        "What animals were sacred in ancient Egypt?",
        "What was Ma’at in Egyptian belief?",
        "Who was Anubis and what did he represent?",
        "What did Egyptians believe about the afterlife?",
        "How were tombs decorated?",
        "What is a mastaba?",
        "What is the Book of the Dead?",
        "What does the ankh symbol mean?",
        "Who was Horus?",
        "What is the Eye of Ra?",
        "What is the significance of Osiris in Egyptian mythology?",
        "Who were the builders of the Valley of the Kings?",
        "How were pharaohs chosen?",
        "Where is the tomb of Seti I?",
        "What is a cartouche?",
        "What were Egyptian temples made of?",
        "What were the festivals in ancient Egypt?",
        "What did ancient Egyptians wear?",
        "What kind of jewelry did Egyptians make?",
        "What is the story of Isis and Osiris?",
        "What do scarabs symbolize in Egyptian culture?",
        "How did Egyptians measure time?",
        "What kind of music did ancient Egyptians have?",
        "How were ancient Egyptian boats made?",
        "What was the role of women in ancient Egypt?",
        "What kinds of pets did Egyptians have?",
        "How did Egyptians treat diseases?",
        "What were the most important deities?",
        "How did Egypt influence Greek culture?",
        "What is the story behind Ramses II’s many statues?",
        "What modern cities are built over ancient ones?",
        "Are there pyramids outside of Giza?",
        "What is the Nubian culture in southern Egypt?",
        "What is the Siwa Oasis known for?",
        "Who was Imhotep and what did he accomplish?",
        "What did ancient Egyptians use for writing?",
        "What is papyrus and how was it made?",
        "What were ancient Egyptian schools like?",
        "Where was ancient Thebes located?",
        "What is the temple of Medinet Habu?",
        "Where is the oldest known pyramid?",
        "What is the Sun Temple of Niuserre?",
        "What is a shabti figure?",
        "What is depicted in the Amarna art style?",
        "What is the importance of the Nile Delta?",
        "What happens during the flooding of the Nile?",
        "Where are Egypt’s UNESCO World Heritage sites?",
        "What is the Qaitbay Citadel?",
        "What are the oldest surviving Egyptian texts?",
        "What’s the difference between Upper and Lower Egypt?",
        "What are some recently discovered tombs in Egypt?",
        "What is the Ministry of Antiquities?",
        "What are Egypt’s most famous archaeological discoveries?",
        "What is the Grand Avenue of Sphinxes?",
        "What is the importance of Gebel el-Silsila?",
        "Are there mummies on display in Egypt?",
        "What are the Crocodile Mummies of Kom Ombo?",
        "How are modern excavations in Egypt conducted?",
        "What is the role of Zahi Hawass in Egyptology?",
        "What are some lesser-known pyramids in Egypt?",
        "Can tourists join archaeological digs in Egypt?",
        "Where is the Pyramid of Unas?",
        "What is the role of UNESCO in Egypt’s sites?",
        "Where are the oldest temples in Egypt?",
        "What is the Temple of Khnum at Esna?",
        "Where was the Library of Alexandria located?",
        "What is the Lighthouse of Alexandria?",
        "Are there any ancient Egyptian theaters?",
        "What is Egypt’s contribution to astronomy?",
        "What did Egyptians know about medicine?",
        "What are Fayum mummy portraits?",
        "What are the tombs of the nobles in Luxor?",
        "What is the Colossus of Memnon?",
        "What is the symbolism of the lotus flower in Egypt?",
        "How is ancient Egypt represented in Hollywood?",
        "What is the oldest map of Egypt?",
        "What was ancient Egyptian currency?",
        "What types of wine did Egyptians drink?",
        "What was the purpose of false doors in tombs?",
        "What did Egyptian soldiers wear and use?",
        "What is the modern significance of ancient Egyptian art?",
        "Are there any Jewish historical sites in Egypt?",
        "What happened during the Battle of Kadesh?",
        "What is the story of the mummy’s curse?",
        "What items are usually found in a burial chamber?"
    ]]
    with open("test_questions.json", "w", encoding="utf-8") as f:
        json.dump(questions, f, indent=2, ensure_ascii=False)
    print("✅ Created test_questions.json with 100 Egypt tourism-focused questions.")

# ----------------------------------------
# 2. Load Questions and Test the API
# ----------------------------------------
def run_tests():
    print("🚀 Running Egypt Tourism QA Tests...\n")
    with open("test_questions.json", "r", encoding="utf-8") as f:
        questions = json.load(f)

    results = []

    for i, item in enumerate(questions, start=1):
        question = item["question"]
        print(f"🧪 Test {i}: {question}")
        try:
            response = requests.post(API_URL, json={"question": question}, timeout=30)
            if response.status_code == 200:
                result = response.json()
                print(f"✅ Answer: {result['answer']}")
                print(f"⏱️  Response Time: {result['response_time_sec']}s\n")
                results.append({
                    "question": question,
                    "answer": result['answer'],
                    "response_time_sec": result['response_time_sec']
                })
            else:
                print(f"❌ Failed: HTTP {response.status_code}\n{response.text}")
        except Exception as e:
            print(f"❌ Exception: {e}\n")

    with open("chatbot_test_results.json", "w", encoding="utf-8") as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
    print("💾 Results saved to chatbot_test_results.json.")

# ----------------------------------------
# 3. Run Tests
# ----------------------------------------
if __name__ == "__main__":
    run_tests()
