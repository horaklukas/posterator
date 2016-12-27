import React, { Component, PropTypes } from 'react';

export default class PosterThumbnail extends Component {
  static propTypes = {
    url: PropTypes.string.isRequired,
    name: PropTypes.string.isRequired,
    selectPoster: PropTypes.func.isRequired
  };

  render() {
    const {selectPoster, id} = this.props;
    const selectPosterById = () => selectPoster(id)

  	return (
	    <div className="card" onClick={selectPosterById}>
        <img className="card-img-top" src={this.props.url} />
        <div className="card-block">
          <h4 className="card-title">{this.props.name}</h4>
        </div>
      </div>
    );
  }
}