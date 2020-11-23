import React from "react";

function Form(props) {
  return (
    <div>
      <h3> New Bullet </h3>
      <form onSubmit={props.onSubmit}>
        <label for="startdate">Start Date: </label>
        <input
          type="date"
          id="startdate"
          name="startdate"
          onChange={props.onChange}
        />
        <br />
        <label for="enddate">End Date: </label>
        <input
          type="date"
          id="enddate"
          name="enddate"
          onChange={props.onChange}
        />
        <br />
        <input
          type="text"
          id="summary"
          name="summary"
          placeholder="Bullet Summary"
          onChange={props.onChange}
        />
        <br />
        <input
          type="text"
          id="narrative"
          name="narrative"
          placeholder="Bullet Narrative"
          onChange={props.onChange}
        />

        <input type="submit" value="Submit" />
      </form>
    </div>
  );
}

export default Form;
