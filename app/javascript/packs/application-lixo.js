
import '../effects/main';
import React from 'react';
import ReactDOM from 'react-dom';
import {Navigation} from '../components/Navigation';
import {ready, qS} from '../utilities';

ready(() => {
  ReactDOM.render(
    <Navigation />,
    qS('#Navigation')
  );
});
