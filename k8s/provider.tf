provider "google" {
  credentials = file("../credentials.json")
  project     = "fresh-rain-311111"
  region      = "europe-west3"
}