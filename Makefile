init:
	# Install bundler if not installed
	if ! gem spec bundler > /dev/null 2>&1; then\
  		echo "bundler gem is not installed!";\
  		-sudo gem install bundler;\
	fi
	-bundle install --path .bundle
	-bundle exec generamba template install
	-bundle exec pod repo update
	-bundle exec pod install

screen: 
	bundle exec generamba gen $(modName) swift_mvc_module