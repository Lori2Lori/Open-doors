React                 = require 'react'
List                  = require 'material-ui/lib/lists/list'
ListDivider           = require 'material-ui/lib/lists/list-divider'
ListItem              = require 'material-ui/lib/lists/list-item'
Avatar                = require 'material-ui/lib/avatar'
moment                = require 'moment'

module.exports = class History extends React.Component
  render: ->
    <div>
      <h2> History </h2>
      <List>
        { if @props.history is null
            <h4>
            </h4>
          else
            for key, event of @props.history
              do =>
                uid = key
                date = moment(event.time)
                description = "#{date.format("YYYY/MM/DD, h:mm a")}, #{event.type} #{event.door?.description or "DOOR DELETED"}"
                <ListItem key = { uid }
                  primaryText = { description }
                />
        }
      </List>
    </div>
