import React from "react";
import BulletList from "./BulletList";
import Form from "./Form";
//import SearchResult from "./SearchResult";

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      userData: [],
      bulletData: [],
      user: { user_id: "" }, //need to get session cookie & user id
      formData: {
        start_date: "",
        end_date: "",
        category: [],
        strength: "",
        summary: "",
        narrative: "",
        bullet_format: "",
        bullet_action: "",
        bullet_impact: "",
        bullet_result: "",
      },
    };
  }

  async componentDidMount() {
    const userResponse = await fetch(`http://localhost:6001/users/`);
    const userJSON = await userResponse.json();
    const bulletResponse = await fetch(`http://localhost:3001/bullets/`); //fetching the bullets the user is responsible for... by cookie & userData eventually
    const bulletJSON = await bulletResponse.json();
    this.setState({
      ...this.state,
      userData: userJSON,
      bulletData: bulletJSON,
    });
  }

  handleUserInput(event) {
    event.preventDefault();
    if (event.target.options) {
      this.setState((prevState) => ({
        formData: {
          ...prevState.formData,
          category: Array.from(
            event.target.selectedOptions,
            (item) => item.value
          ),
        },
      }));
    } else {
      const { name, value } = event.target;
      this.setState((prevState) => ({
        formData: {
          ...prevState.formData,
          [name]: value,
        },
      }));
    }
  }

  getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min) + min); //The maximum is exclusive and the minimum is inclusive
  }

  handleFormSubmit(event) {
    event.preventDefault();
    console.log(JSON.stringify(this.state.formData, null, 2));
    //format form data into a json
    //that can be passed as the req body in POST /new
  }

  render() {
    return (
      <div>
        <Form
          onChange={this.handleUserInput.bind(this)}
          onSubmit={this.handleFormSubmit.bind(this)}
        />
        <BulletList
          bullets={this.state.bulletData}
          numRand={this.getRandomInt.bind(this)}
        />
      </div>
    );
  }
}

export default App;
