if ENV['SECRET_KEY_BASE']
  Rails.application.secrets.secret_key_base = ENV['SECRET_KEY_BASE']
else
  unless File.exists?("config/session_token.yml")
    puts ">> Generating new secret token in config/secret_token.yml"
    File.open("config/session_token.yml", "w") do |f|
      f.write SecureRandom.hex(128).to_yaml
    end
  end
  Rails.application.secrets.secret_key_base = YAML.load(File.read("config/session_token.yml"))
end
