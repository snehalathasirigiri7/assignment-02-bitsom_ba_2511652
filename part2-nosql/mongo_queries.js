// OP1: insertMany() — insert all 3 documents from sample_documents.json
const electronics = {
  _id: "E1001",
  category: "Electronics",
  name: "4K Smart LED TV",
  brand: "ViewMax",
  price: 45999,
  specs: {
    warranty_years: 2,
    voltage: "220-240V",
    screen_size: "55 inch",
    features: ["HDR10+", "Dolby Vision", "WiFi", "Bluetooth"]
  }
};

const clothing = {
  _id: "C2001",
  category: "Clothing",
  name: "Women's Winter Jacket",
  brand: "SnowShell",
  price: 3499,
  sizes: ["S", "M", "L", "XL"],
  materials: { outer: "Nylon", inner: "Fleece" },
  available_colors: ["Red", "Black", "Blue"],
  care_instructions: ["Hand wash", "Do not iron", "Do not bleach"]
};

const groceries = {
  _id: "G3001",
  category: "Groceries",
  name: "Organic Brown Rice",
  brand: "HealthyGrain",
  price: 249,
  weight_kg: 1,
  nutrition: {
    calories: 216,
    carbs_g: 44,
    protein_g: 5,
    fiber_g: 3.5
  },
  expiry: "2027-02-12",
  certifications: ["FSSAI Certified", "Organic India"]
};

// OP1: insertMany()
db.products.insertMany([electronics, clothing, groceries]);

// OP2: find() — Electronics with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() — Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry: { $lt: "2025-01-01" }
});

// OP4: updateOne() — add discount_percent field
db.products.updateOne(
  { _id: "E1001" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — index on category
db.products.createIndex({ category: 1 });
// This improves query performance for category-based filtering, especially
// useful because the catalog frequently queries by product category.