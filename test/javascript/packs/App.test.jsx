import React from 'react';
import { shallow, mount } from 'enzyme';
import { Provider } from "react-redux";
import configureMockStore from "redux-mock-store";

import App from 'packs/App';

const mockStore = configureMockStore();
const store = mockStore({});

describe("App", () => {
  it("renders correctly", () => {
    const wrapper = shallow(
      <Provider store={store}>
          <App />
      </Provider>
    )
    expect(wrapper).toMatchSnapshot();
  });
});