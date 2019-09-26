import React from 'react';
import { shallow, mount } from 'enzyme';
import { Provider } from "react-redux";
import configureMockStore from "redux-mock-store";

import Signup from 'packs/Modals/Signup';

const mockStore = configureMockStore();

describe("Signup", () => {
  it("renders correctly", () => {
    const wrapper = shallow(
      <Provider store={mockStore({})}>
          <Signup />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });

  it("renders correctly with user logged in", () => {
    const wrapper = shallow(
      <Provider store={mockStore({user: {name: 'Yasir'}})}>
          <Signup />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });
});