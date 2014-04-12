Branch = require './branch'
{git} = require '../git'

module.exports =
class RemoteBranch extends Branch
  name: ->
    @get "name"

  local_name: ->
    @name()

  remote_name: -> ""

  short_commit_id: ->
    commit = @get("commit")
    commit.id.substr(0, 6) if commit

  short_commit_message: ->
    commit = @get("commit")
    return "" if not commit
    message = commit.message.split("\n")[0]

  kill: ->
    atom.confirm
      message: "Delete branch #{@name()}?"
      buttons:
        "Delete": => @delete()
        "Cancel": null

  checkout: (callback)->
    git.git "checkout #{@local_name()}"
