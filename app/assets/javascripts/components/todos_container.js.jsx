var TodosContainer = React.createClass({

  getInitialState: function () {
    return {
      todos: [],
      new_todo_title: ''
    }
  },

  componentDidMount: function () {
    var that = this;
    $.ajax({
      url: "/todos",
      dataType: "json",
      success: function(todos){
        that.setState( { todos: todos } );
      }
    })
  },

  handleRemove: function(todo){
    var that = this;

    $.ajax({
      url : "/todos/" + todo.id,
      type: "DELETE",
      success: function(data){
        var todos = $.grep(that.state.todos, function(e){
          return e.id != data.id
        });

        that.setState( { todos: todos });
      }
    })

  },

  handleChange: function(evt){
    console.log(evt);
    this.setState( { new_todo_title: evt.target.value } )
  },
  handleSubmit: function(){
    var that = this;
    $.ajax({
      url: "/todos",
      type: "POST",
      data: {
        title: that.state.new_todo_title
      },
      dataType: "json",
      success: function(data){
        var todos = that.state.todos;
        todos.push(data);

        that.setState( { todos: todos,
                         new_todo_title: ""
                       });
      }
    })
  },
  render: function(){
    return (
      <div>
        <input type="text" value={this.state.new_todo_title} onChange={this.handleChange} />
        <input type="submit" onClick={ this.handleSubmit } />
        <TodoList todos={this.state.todos} onRemoveClick={ this.handleRemove } />
      </div>
    )
  }

})
