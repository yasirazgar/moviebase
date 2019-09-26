import React from 'react';
import { shallow, mount } from 'enzyme';
import { Provider } from "react-redux";
import configureMockStore from "redux-mock-store";

import EditMovie from 'packs/Modals/EditMovie';

const mockStore = configureMockStore();

describe("EditMovie", () => {
  it("renders correctly", () => {
    const wrapper = shallow(
      <Provider store={mockStore({})}>
          <EditMovie />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });

  it("renders correctly with user logged in", () => {
    const wrapper = shallow(
      <Provider store={mockStore({user: {name: 'Yasir'}})}>
          <EditMovie />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });
});