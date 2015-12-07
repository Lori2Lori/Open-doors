React                 = require 'react'
RaisedButton          = require 'material-ui/lib/raised-button'
Card                  = require 'material-ui/lib/card/card'
CardTitle             = require 'material-ui/lib/card/card-title'
CardMedia             = require 'material-ui/lib/card/card-media'
CardActions           = require 'material-ui/lib/card/card-actions'
Dialog                = require 'material-ui/lib/dialog'
TextField             = require 'material-ui/lib/text-field'
GridList              = require 'material-ui/lib/grid-list/grid-list'
GridTile              = require 'material-ui/lib/grid-list/grid-tile'
FlatButton            = require 'material-ui/lib/flat-button'

module.exports = class Open extends React.Component
  render: ->
    <div>
      <h2>Open doors</h2>

      <Dialog
        title = "Door is opened"
        open = {@state.dialog}
        actions = {[
          <FlatButton label="OK"
            onClick = { => @setState dialog: no }

          />
        ]}
      >
      </Dialog>

      <GridList
        style={overflowY: "auto", margin: 10}
        cols = 3
        >
        { if @props.doors is null
            <h4>
              Welcome! Add a door to get started
            </h4>
          else
            for key, door of @props.doors
              do =>
                uid = key

                <Card key={uid}>
                  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Solid_white.png/100px-Solid_white.png"/>
                  <CardMedia
                    overlay= {
                      <CardTitle
                        title = { door.description }
                      >
                      </CardTitle>
                    }
                  >
                  </CardMedia>
                  <CardActions>
                    <FlatButton
                      label="Open"
                      onClick = { =>
                        @setState dialog: yes
                        @props.onDoorOpen
                          time : Date.now()
                          type : "opened"
                          door : uid
                          user : "Ann Lou"
                      }
                      />
                  </CardActions>
                </Card>
        }
      </GridList>

    </div>

  constructor: ->
    @state = dialog: no
