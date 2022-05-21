<h1 align="center"><img src="https://github.com/octree-gva/meta/blob/main/decidim/static/header.png?raw=true" alt="Decidim - Octree Participatory democracy on a robust and open source solution"></h1>
<h4 align="center">
    <a href="https://www.octree.ch">Octree</a> |
    <a href="https://octree.ch/en/contact-us/">Contact Us</a> |
    <a href="https://blog.octree.ch">Our Blog (FR)</a><br/><br/>
    <a href="https://decidim.org">Decidim</a> |
    <a href="https://docs.decidim.org/en/">Decidim Docs</a> |
    <a href="https://meta.decidim.org">Participatory Governance (meta decidim)</a><br/><br/>
    <a href="https://matrix.to/#/+decidim:matrix.org">Decidim Community (Matrix+Element.io)</a> |
    <a href="https://github.com/PopulateTools/decidim-module-extra_user_fields">Original Sources</a>
</h4>


# Decidim::ExtraUserFields

This is a fork from [decidim-module-extra_user_fields](https://github.com/PopulateTools/decidim-module-extra_user_fields), developed by [Populate Tools](http://populate.tools). This repository adapt the fields to match needs of the Mkutano community, Canada.


* Allows to collect and manage some extra user fields on registration and profile edition.
* Adds a link in admin participants panel to download users of organization in several formats.

## Installation

Add this line to your application's Gemfile:

Only Decidim 0.24 is supported:
```ruby
gem "decidim-extra_user_fields", git: "https://github.com/octree-gva/decidim-module-mkutano-extra_user_fields", branch: "release/0.24-stable"
```

And then execute:

```bash
bundle
```
## Local development
Run if you haven't already:
```bash
bundle
```

And then
```bash
    rake decidim:generate_external_development_app
```

Run a postgres database
```
docker-compose up -d
```

Setup and run the decidim development server
```
cd development_app
export DATABASE_USERNAME=decidim DATABASE_PASSWORD=my-insecure-password RAILS_ENV=development
rails db:migrate
rails db:seed
rails s
```
Access your local environment [localhost:3000](http://localhost:3000)

## Contributing

We are not ready yet for contributions.

## License

This engine is distributed under the [GNU AFFERO GENERAL PUBLIC LICENSE](LICENSE.md)

<br /><br />
<p align="center">
    <img src="https://raw.githubusercontent.com/octree-gva/meta/main/decidim/static/octree_and_decidim.png" height="90" alt="Decidim Installation by Octree" />
</p>