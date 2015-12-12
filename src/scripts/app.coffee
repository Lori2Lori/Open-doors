React      = require 'react'
RDOM       = require 'react-dom'
Doors      = require './Doors'
History    = require './History'
Open       = require './Open'
Login      = require './Login'
Register   = require './Register'

# Material-ui styles
Dialog     = require 'material-ui/lib/dialog'
FlatButton = require 'material-ui/lib/flat-button'

do require 'react-tap-event-plugin'
Tabs       = require 'material-ui/lib/tabs/tabs'
Tab        = require 'material-ui/lib/tabs/tab'

# Database
Firebase   = require 'firebase'
database   = new Firebase 'https://clay-app.firebaseio.com/'
doors      = database.child 'doors'
history    = database.child 'history'

class Main extends React.Component
  render: ->
    <div className="app">

      {
        if not @state.user?
          <div>
            <Register
              onNewUser = { (credentials) =>
                database.createUser credentials, (error, userData) =>
                  if error
                    return console.error "Error creating user:", error

                  console.log "Successfully created user account with uid:", userData.uid
              }
            />
            <Login
              onLogin = { (credentials) =>
                database.authWithPassword credentials, (error, authData) =>
                  if error
                    return console.error "Login error", error
                  user = authData.uid
                  @setState {user}

                  doors
                    .child user
                    .on 'value', (snapshot) =>
                      @setState doors: snapshot.val()
              }
            />
          </div>
        else

          <Dialog
            title="Please provide correct email and password"
            open={@state.error}
            actions = {[
              <FlatButton label="Close"
                onClick = { => @setState error: no }
              />
            ]}
          >
          </Dialog>

          <Tabs>
            <Tab label="Manage doors" >
              <Doors
                doors = { @state.doors }
                onNewDoor = { (door) =>
                  # Create new collection of doors with name equal @state.user (uid)
                  # Push door object to this new collection
                  (doors.child @state.user).push door
                }
                #TODO: Update deleting doors
                onClear = { (name) =>
                  doors
                    .child name
                    .remove()
                }
              />

            </Tab>

            <Tab label="Open doors" >
              <Open
                doors = { @state.doors }
                onNewDoor = { (door) => doors.push door }
                onDoorOpen = { (event) =>
                  history.push event }
              />
            </Tab>

            <Tab label="History" >
              <History
                history = {@state.history}
              />
            </Tab>
          </Tabs>
      }
    </div>

  constructor: ->
    @state = doors: {}, history: {}, user: null

  componentWillMount: ->

    # Join properties from two arrays: history and doors
    # Request history on every change of its value
    history.on 'value', (snapshot) =>
      # Take a value from history snapshot
      events = snapshot.val()
      # Request for doors once and wait for the answer
      doors.on 'value', (snapshot) =>
        # Take value from items snapshot
        items = snapshot.val()
        # For each event, take door description and put it into door property of event
        for uid, event of events
          door = items[event.door]
          event.doorObject = door
        # Set state of history to the current events, with new door property.
        @setState history: events
        #Each door property in event has the description from doors array.

element = React.createElement Main
RDOM.render element, document.querySelector '.container'
