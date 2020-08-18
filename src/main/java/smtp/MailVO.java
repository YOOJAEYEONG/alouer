package smtp;

public class MailVO {
	
	private String from;
	private String to;
	private String subject;//제목
	private String contents;//내용
	//기본생성자
	public MailVO() {}
	//인자 생성자
	public MailVO(String from, String to, String subject, String contents) {
		super();
		this.from = from;
		this.to = to;
		this.subject = subject;
		this.contents = contents;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
}
