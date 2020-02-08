import React, { Component } from "react";
 
class CreateElection extends Component {
  constructor(props) {
    super(props);
    this.state = { electionName: '' };
    this.state = { loading: false };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({electionName: event.target.value});
  }

  async handleSubmit(event) {
    console.log(this.props.account)
    this.setState({ loading: true })
    this.props.electionManager.methods.createElection(this.state.electionName).send({ from: this.props.account })
    .once('receipt', (receipt) => {
      console.log(receipt)
      this.setState({ loading: false })
    })
    event.preventDefault();
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Name:
          <br/>
          <input type="text" value={this.state.electionName} onChange={this.handleChange} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}
 
export default CreateElection;