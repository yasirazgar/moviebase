import React from 'react';
import { shallow, mount } from 'enzyme';
import { Provider } from "react-redux";
import configureMockStore from "redux-mock-store";

import App from 'packs/App';

const mockStore = configureMockStore();

describe("App", () => {
  it("renders correctly", () => {
    const wrapper = shallow(
      <Provider store={mockStore({})}>
          <App />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });

  it("renders correctly with user logged in", () => {
    const wrapper = shallow(
      <Provider store={mockStore({user: {name: 'Yasir'}})}>
          <App />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });
});