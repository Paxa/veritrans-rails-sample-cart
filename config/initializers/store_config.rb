raw_config = File.read("#{Rails.root}/config/veritrans.yml")
CONFIG = YAML.load(raw_config)[Rails.env].symbolize_keys