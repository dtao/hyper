# Hyper

Hyper lets you create a full Rails app in no time, just by defining your domain in a YAML file.

## Note

This gem is nowhere near ready for production use yet. Or even development use, really. I'm working on it; stay tuned.

## Usage

Create a file called **hyper.yml** in the root directory of (what will become) your Rails application.

Here's an example of what that file could look like:

```yaml
name: My Awesome App

tagline:
  The awesomest app ever

models:
  User:
    attributes:
      name: string !primary
      email: string

  Post:
    attributes:
      user: User
      title: string
      content: text

  Comment:
    attributes:
      user: User
      post: Post
      content: text
```

Once you've defined some models (your domain) in hyper.yml, run Hyper from the command line:

    hyper

This will populate your Rails app with all the boilerplate you don't feel like writing.
