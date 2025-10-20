print("🤖 Smart Data Filter Bot")
print("AI is cleaning and categorizing data before training...\n")
# Sample mixed dataset (numbers = features, text = noisy data)
raw_data = [23, "error", 57, "missing", 81, 42, "corrupt", 90, 101, "ok", 60]
clean_data = []
bad_data = []
threshold = 70
# for loop + if/else + continue/pass
for item in raw_data:
    if type(item) != int:
        print(f"⚠️  Skipping invalid entry: {item}")
        bad_data.append(item)
        continue
    if item > threshold:
        print(f"🔥 High-quality data: {item}")
    elif item > 40:
        print(f"✅ Moderate-quality data: {item}")
    else:
        print(f"📉 Low-quality data: {item}")
    clean_data.append(item)
print("\n✅ Data cleaning complete!")
print(f"Cleaned entries: {len(clean_data)} | Bad entries: {len(bad_data)}\n")
# enumerate() to show indexed clean data
print("📊 Clean Data Overview:")
for i, val in enumerate(clean_data, 1):
    print(f"Index {i} → Value: {val}")
print("\n🏁 Data ready for model training!")