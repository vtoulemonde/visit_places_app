Heroku Deployment

Problems encountered
1.
== 20141009190600 RemoveFileNameFromPhotos: migrating =========================
-- remove_column(:photos, :picture_file_name, :string)
rake aborted!
StandardError: An error has occurred, this and all later migrations canceled:

PG::UndefinedColumn: ERROR:  column "picture_file_name" of relation "photos" does not exist
: ALTER TABLE "photos" DROP "picture_file_name"/app/vendor/bundle/ruby/2.0.0/gems/activerecord-4.1.6/lib/active_record/connection_adapters/postgresql/database_statements.rb:128:in `async_exec'

2. 
Heroku page up, but does not look as per local repo

3. 
2014-10-09T21:14:38.030424+00:00 heroku[router]: at=info method=GET path="/" host=fathomless-ocean-5895.herokuapp.com request_id=6221aa3b-fa42-421c-bd93-12ff94198b74 fwd="199.87.83.154" dyno=web.1 connect=1ms service=254ms status=200 bytes=5243

2014-10-09T21:14:38.326001+00:00 heroku[router]: at=info method=GET path="/assets/application-c494d30a67708c8becb9fd9e5ef9d9ef.js" host=fathomless-ocean-5895.herokuapp.com request_id=240cd6ee-4d01-4d64-ab69-f985b8cc0b12 fwd="199.87.83.154" dyno=web.1 connect=1ms service=9ms status=404 bytes=1829

4. 
Checked unicorn gem exists
➜  visit_places_app git:(master) gem which unicorn
/Users/coenching/my-ruby/lib/ruby/gems/2.1.0/gems/unicorn-4.8.3/lib/unicorn.rb

and stopped following Heroku guide after Unicorn section