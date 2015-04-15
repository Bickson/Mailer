require 'net/imap'

class UserMailer < ActionMailer::Base
  default from: "johan.emil.lundgren@gmai.com"

  def get_emails
    #imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
    #imap.login('johan.emil.lundgren@gmail.com', 'hxzxodggaacuvlrb')
    imap = Net::IMAP.new("imap.gmail.com", 993,true)
    imap.login("johan.emil.lundgren@gmail.com", "hxzxodggaacuvlrb")
    imap.select('INBOX')
    imap.search(["SINCE", "1-Apr-2015"]).each do |message_id|
      mail = imap.fetch(message_id,"ENVELOPE")[0].attr["ENVELOPE"] #fetching envelope objects
      puts "Subject: #{mail.subject} \nFrom: #{mail.from[0].mailbox}@#{mail.from[0].host}"
      mail = imap.fetch(message_id,"RFC822.TEXT")[0].attr["RFC822.TEXT"]
      puts mail
      #new_mail = Email.new()
      #new_mail.subject = mail.subject
      #puts "Subject: #{mail.subject} \nFrom: #{mail.from[0].mailbox}@#{mail.from[0].host}"
    end
    #imap.search(["SINCE", "1-Apr-2015"]).each do |message_id|
    #  envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
    #  puts "#{envelope.from[0].name}: \t#{envelope.subject}"
    #  @list << [envelope.from[0].name,envelope.subject]
    #end
    imap.logout
    imap.disconnect
  end


  def welcome_email(user)
    @user = user
    @url = "https://accounts.google.com"
    mail(to: @user.email, subject: "welcome to an awsome app biatch")
  end

end
