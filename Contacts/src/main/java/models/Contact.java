package models;

public class Contact {
	private int id;
	
	private String nom;
	private String prenom;
	private int tel;
	private String adresse;
	private String email;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public int getTel() {
		return tel;
	}
	public void setTel(int i) {
		this.tel = i;
	}
	public String getAdresse() {
		return adresse;
	}
	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
	

	public int getId() {
		return id;
	}
	public void setId(int i) {
		this.id = i;
	}

	

}
