import pandas as pd
import json

# Charger le fichier Excel
df = pd.read_excel('translations.xlsx')

# Vérification
required_columns = {'key', 'en', 'ar'}
if not required_columns.issubset(df.columns):
    raise Exception("Le fichier Excel doit contenir les colonnes : key, en, ar")

# Générer les fichiers ARB
for lang in ['en', 'ar']:
    arb_data = {"@@locale": lang}
    for _, row in df.iterrows():
        key = row['key']
        value = row[lang]
        arb_data[key] = value

    # Sauvegarder dans un fichier .arb
    with open(f'app_{lang}.arb', 'w', encoding='utf-8') as f:
        json.dump(arb_data, f, ensure_ascii=False, indent=2)

print("✅ Fichiers app_en.arb et app_ar.arb générés avec succès !")
