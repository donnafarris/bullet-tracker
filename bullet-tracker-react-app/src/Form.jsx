import React from "react";

function Form(props) {
  return (
    <div>
      <h3> New Bullet </h3>
      <form onSubmit={props.onSubmit}>
        <label htmlFor="startdate">Start Date: </label>
        <input
          type="date"
          id="startdate"
          name="startdate"
          onChange={props.onChange}
          required
        />
        <br />
        <label htmlFor="enddate">End Date: </label>
        <input
          type="date"
          id="enddate"
          name="enddate"
          onChange={props.onChange}
        />
        <br/>
        <select name="category" id="category" onChange={props.onChange} multiple>
          <option value="">--Please choose an option--</option>
          <option value="Education">Education</option>
          <option value="Primary Duties">Primary Duties</option>
          <option value="Volunteer">Volunteer</option>
          <option value="Leadership">Leadership</option>
        </select>
        <br />
        <input
          type="text"
          id="summary"
          name="summary"
          placeholder="Bullet Summary"
          onChange={props.onChange}
          required
        />
        <br />
        <input
          type="text"
          id="narrative"
          name="narrative"
          placeholder="Bullet Narrative"
          onChange={props.onChange}
        />
        <br/>
        <input
          type="text"
          id="bullet_action"
          name="bullet_action"
          placeholder="Bullet Action"
          onChange={props.onChange}
        />
        <br/>
        <input
          type="text"
          id="bullet_impact"
          name="bullet_impact"
          placeholder="Bullet Impact"
          onChange={props.onChange}
        />
        <br/>
        <input
          type="text"
          id="bullet_result"
          name="bullet_result"
          placeholder="Bullet Result"
          onChange={props.onChange}
        />
        <br/>
        <input type="submit" value="Submit" />
      </form>
    </div>
  );
}

export default Form;
