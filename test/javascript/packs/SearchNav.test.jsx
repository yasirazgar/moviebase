import React from 'react';
import { shallow, mount } from 'enzyme';
import { Provider } from "react-redux";
import configureMockStore from "redux-mock-store";

import SearchNav from 'packs/SearchNav';

const mockStore = configureMockStore();

describe("SearchNav", () => {
  it("renders correctly", () => {
    const wrapper = shallow(
      <Provider store={mockStore({})}>
          <SearchNav />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });

  it("renders correctly with user logged in", () => {
    const wrapper = shallow(
      <Provider store={mockStore({user: {name: 'Yasir'}})}>
          <SearchNav />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });
});