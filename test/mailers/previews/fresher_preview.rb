# Preview all emails at http://localhost:3000/rails/mailers/fresher
class FresherPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/fresher/new_verification
  def new_verification
    Fresher.new_verification
  end

end
