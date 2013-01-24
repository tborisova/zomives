class IndexController < ApplicationController
  def index	 
		a = Mechanize.new
		a.get("http://zamunda.net/login.php")
		
		form = a.page.forms.select {|f| f.action == "takelogin.php"}[0]
		form.fields[0].value = "mars15"
		form.fields[1].value = "ip_project"
		
		form.submit
		
		a.get "http://zamunda.net/catalogue.php?catalog=movies"
  end
end
