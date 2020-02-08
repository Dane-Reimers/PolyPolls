import React, { Component } from "react";
 
class Home extends Component {
  render() {
    return (
      <div>
        <h2>Home</h2>
        <h3>There are { this.props.numElections } election(s)</h3>
      </div>
    );
  }
}
 
export default Home;