import React from 'react';
import {Link} from 'react-router-dom';

function NavBar (props) {
  const {user, onSignOut = () => {}} = props;


  return (
    <nav
      style={{
        padding: '10px',
        display: 'flex',
      }}
    >
      <Link style={{marginRight: '20px'}} to="/">Get a Job</Link>

        <div style={{marginLeft: 'auto', marginRight: '20px',display: 'flex'}}>
          <Link
            style={{marginLeft: 'auto', marginRight: '20px'}}
            to="/boards"
            >
              Boards
          </Link>
          <Link
            style={{marginLeft: 'auto', marginRight: '20px'}}
            to="/boards/new"
            >
              Create New Board
          </Link>
          {
        user ? (
          <div className= "Sign">
          <span
            style={{marginLeft: 'auto', marginRight: '20px'}}
          >
            Hello, {user.email}
          </span>
          <Link
            style={{marginLeft: 'auto', marginRight: '20px'}}
            to="/"
            onClick={onSignOut}
            >
              Sign Out
          </Link>
        </div>
        ) : ([
          <div className= "Sign">
          <Link
            style={{marginLeft: 'auto', marginRight: '20px'}}
            to="/sign_in"
            >
              Sign In
          </Link>
          <Link
            style={{marginLeft: 'auto', marginRight: '20px'}}
            to="/sign_up"
            >
              Sign Up
          </Link>
          </div>
        ])
      }
      </div>
    </nav>
  );
}

export {NavBar};
