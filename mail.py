import smtplib as smp

s = smp.SMTP("smtp.gmail.com" , 587)
s.starttls()
s.login("email_id" , "*Password*")
message = "Your Model is successfully trained".format(total//counter)
s.sendmail("senders_mail_id" , "********" , message)
s.quit()
