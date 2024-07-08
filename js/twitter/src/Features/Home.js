import "./Home.css";
import { useState } from "react";

function Home() {
  return (
    <div className="App">
      <TabBar>
        <Tab label="For You">
          <div>Content for For You</div>
        </Tab>
        <Tab label="Following">
          <div>Content for Follwing</div>
        </Tab>
      </TabBar>
    </div>
  );
}

const TabBar = ({ children }) => {
  const [activeTab, setActiveTab] = useState(children[0].props.label);

  const onClickTabItem = (tab) => {
    setActiveTab(tab);
  };

  return (
    <div className="tab-bar">
      <ol className="tab-list">
        {children.map((child) => {
          const { label } = child.props;

          return (
            <li
              key={label}
              className={
                label === activeTab
                  ? "tab-list-item tab-list-active"
                  : "tab-list-item"
              }
              onClick={() => onClickTabItem(label)}
            >
              {label}
            </li>
          );
        })}
      </ol>
      <div className="tab-content">
        {children.map((child) => {
          if (child.props.label !== activeTab) return undefined;
          return child.props.children;
        })}
      </div>
    </div>
  );
};

const Tab = ({ label, children }) => {
  return <div label={label}>{children}</div>;
};

export default Home;
