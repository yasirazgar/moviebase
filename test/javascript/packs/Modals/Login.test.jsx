import React from 'react';
import { shallow, mount } from 'enzyme';
import { Provider } from "react-redux";
import configureMockStore from "redux-mock-store";

import Login from 'packs/Modals/Login';

const mockStore = configureMockStore();

describe("Login", () => {
  it("renders correctly", () => {
    const wrapper = shallow(
      <Provider store={mockStore({})}>
          <Login />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });

  it("renders correctly with user logged in", () => {
    const wrapper = shallow(
      <Provider store={mockStore({user: {name: 'Yasir'}})}>
          <Login />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });
});