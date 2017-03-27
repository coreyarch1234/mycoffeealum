# Preview all emails at http://localhost:3000/rails/mailers/make_mentor_mailer
class MakeMentorMailerPreview < ActionMailer::Preview
    def sample_mail_preview
        MakeMentorMailer.sample_email(User.find(7))
    end
end
