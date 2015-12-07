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

module.exports = class Doors extends React.Component
  render: ->
    <div>
      <h2>Add doors</h2>

      <RaisedButton
        style={margin: 10}
        label="Add door"
        onClick = { =>
          @setState dialog: yes
        }
      />

      <Dialog
        title = "Add door"
        open = {@state.dialog}
        actions = {[
          <FlatButton label="Add door"
            style = {color: "green"}
            onClick = { =>
              @props.onNewDoor
                description: @refs.description.getValue()
              @setState dialog: no }
          />
          <FlatButton label="Cancel"
            onClick = { => @setState dialog: no }
          />
        ]}
      >
        <TextField
          ref="description"
          floatingLabelText="description"
        />
      </Dialog>

      <GridList
        style={overflowY: "auto", margin: 10}
        cols = 3
        >
        { if @props.doors is null
            <h4>
              Welcome! Add door to get started
            </h4>
          else
            for key, door of @props.doors
              do =>
                name = key
                <Card key={name}>
                  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Solid_white.png/100px-Solid_white.png"/>
                  <CardMedia
                    overlay= {
                      <CardTitle
                        title={door.description}
                      />
                    }
                  >
                  </CardMedia>
                  <CardActions>
                    <FlatButton
                      label="Delete"
                      onClick = { => @props.onClear name }
                    />
                  </CardActions>
                </Card>
        }
      </GridList>

    </div>

  constructor: ->
    @state = dialog: no
