import React from 'react';
import { shallow, mount } from 'enzyme';
import { Provider } from "react-redux";
import configureMockStore from "redux-mock-store";

import Movies from 'packs/Movies';

const mockStore = configureMockStore();

describe("Movies", () => {
  it("renders correctly", () => {
    const wrapper = shallow(
      <Provider store={mockStore({})}>
          <Movies />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });

  it("renders correctly with user logged in", () => {
    const wrapper = shallow(
      <Provider store={mockStore({user: {name: 'Yasir'}})}>
          <Movies />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });
});