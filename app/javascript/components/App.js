import React, {Component} from 'react';
import {
  HomePage,
  NotFoundPage
} from './pages';
import {NavBar} from './NavBar';
import {AuthRoute} from './AuthRoute';
import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom';
import jwtDecode from 'jwt-decode';

class App extends Component {
  constructor (props) {
    super(props);
  }

  componentDidMount () {
  }

  render () {

    return (
      <Router basename="/client">
        <div className="App">
          <NavBar
          />
          <Switch>
            <Route exact path="/" component={HomePage} />
            <Route component={NotFoundPage} />
          </Switch>
        </div>
      </Router>
    );
  }
}

export default App;
