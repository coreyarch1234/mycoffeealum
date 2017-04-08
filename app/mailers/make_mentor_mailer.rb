class MakeMentorMailer < ActionMailer::Base
    default from: "example@mail.com"
    def sample_email(user)
        @user = user
        mail(to: @user.email, subject: 'Congrats! You have a new connection')
    end
end
