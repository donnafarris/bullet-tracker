import React from "react";

function BulletList(props) {
  return (
    <div>
      <h3> Your Bullets </h3>
      <ul>
        {props.bullets.map((bullet) => {
          <li>{bullet}</li>;
        })}
      </ul>
    </div>
  );
}

export default BulletList;
