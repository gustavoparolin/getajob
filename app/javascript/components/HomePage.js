import React from 'react';
import { Jumbotron, Button } from 'reactstrap';
import {Link} from 'react-router-dom';


function HomePage (props) {
  return (
    <main
      className='HomePage'
      style={{padding: '0 20px'}}
    >
      <Jumbotron>
  <h1>Welcome to Get a Job</h1>
  <p>
    This is a simple auction site.
  </p>
  <p>
    <Link
      style={{marginLeft: 'auto', marginRight: '20px'}}
      to="/sign_in"
      >
        <Button bsStyle="primary">Sign In</Button>
    </Link>
  </p>
</Jumbotron>
    </main>
  );
}

export {HomePage};
