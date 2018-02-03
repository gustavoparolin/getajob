import React, {Component} from 'react';
import {
  Collapse,
  Navbar,
  NavbarToggler,
  NavbarBrand,
  Nav,
  NavItem,
  NavLink
} from 'reactstrap';

class Navigation extends Component {
  constructor (props) {
    super(props);

    console.log(props);

    this.state = {
      isOpen: false
    };
    this.toggle = this.toggle.bind(this);
  }

  toggle () {
    this.setState({isOpen: !this.state.isOpen})
  }

  render () {
    return (
      <Navbar color="primary" dark expand="md">
        <NavbarBrand href="/">Get a Job</NavbarBrand>
        <NavbarToggler onClick={this.toggle}/>

        <Collapse isOpen={this.state.isOpen} navbar>
          <Nav className="ml-auto" navbar>
            <NavItem>
              <NavLink href="/">Home</NavLink>
            </NavItem>
          </Nav>
        </Collapse>
      </Navbar>
    );
  }
}

export {Navigation};
