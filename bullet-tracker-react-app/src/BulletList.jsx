import React from "react";

function BulletList(props) {
  return (
    <div>
      <h3> Your Bullets </h3>
      <table border="1px">
        <thead>
          <tr>
            {props.bullets.map((bullet) => {
              let bulletArr = Object.entries(bullet);
              return bulletArr.map((pair) => {
                return <th>{pair[0]}</th>;
              });
            })}
          </tr>
        </thead>
        <tbody>
          {props.bullets.map((bullet) => {
            let bulletArr = Object.entries(bullet);
            return (
              <tr>
                {bulletArr.map((pair) => {
                  return <td>{pair[1]}</td>;
                })}
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}

export default BulletList;
