import React from "react";
import Form from "./Form";
//import SearchResult from "./SearchResult";

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      userData: [],
      bulletData: [],
      user: {user_id: ""}
    };
  }

  async componentDidMount() {
    const userResponse = await fetch(`http://localhost:6001/users/`);
    const userJSON = await userResponse.json();
    //const bulletResponse = await fetch(`http:localhost:3001/bullets/`);
    //const bulletJSON = await bulletResponse.json();
    //const bulletJSONstring = JSON.stringify(bulletJSON);
    //console.log(bulletJSONstring);
    this.setState({
      ...this.state,
      userData: userJSON,
      //bulletData: bulletJSONstring,
    });
  }

  handle(event) {
    event.preventDefault();
    this.setState({ user: { user_id: event.target.value } });
  }

  render() {
    return (
      <div>
        <p>{JSON.stringify((this.state.userData).slice(0, 3)).replace(/,/g, "\n")}</p>
        <Form />
      </div>
    );
  }
}

export default App;
