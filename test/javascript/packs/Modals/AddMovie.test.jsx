import React from 'react';
import { shallow, mount } from 'enzyme';
import { Provider } from "react-redux";
import configureMockStore from "redux-mock-store";

import AddMovie from 'packs/Modals/AddMovie';

const mockStore = configureMockStore();

describe("AddMovie", () => {
  it("renders correctly", () => {
    const wrapper = shallow(
      <Provider store={mockStore({})}>
          <AddMovie />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });

  it("renders correctly with user logged in", () => {
    const wrapper = shallow(
      <Provider store={mockStore({user: {name: 'Yasir'}})}>
          <AddMovie />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });
});