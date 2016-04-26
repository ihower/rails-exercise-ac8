var Item = React.createClass({
  render: function(){
    return (
      <span>
        { this.props.name }
      </span>
    )
  }
})

var Hello = React.createClass({
  getInitialState: function(){
    return {
      name: "ihower"
    }
  },
  add: function(){
    this.setState( { name: "new name" } )
  },
  render: function(){
    return (
      <div>
        <a onClick={this.add}>Add</a>
        <Item name={ this.state.name } />
      </div>
    )
  }

})
