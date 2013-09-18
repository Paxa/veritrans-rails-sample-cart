if true # avoid poluting global space
  extra_groups = ENV['HEROKU_POSTGRESQL_COPPER_URL'] ? [:heroku] : []
  if ARGV.any? {|a| a == "assets:precompile" }
    extra_groups << :assets
  end

  Bundler.require(*extra_groups)
end