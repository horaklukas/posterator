import React from 'react';
import {Grid, Row, Col} from 'react-bootstrap';
import {map as _map} from 'lodash';

import PosterThumbnail from './PosterThumbnail';

import './PosterSelect.styl';

export const PosterSelect = (props) => {
  return (
    <div className="poster-select">
      <Grid fluid>
        <Row>
          { PostersList(props.posters.posters, props.actions.selectPoster) }
        </Row>
      </Grid>
    </div>
  );
}

const PostersList = (posters, selectPoster) => {
  return _map(posters, ({name, url}, id) =>
    (
      <Col md={4} key={`thumb-col-${id}`}>
        <PosterThumbnail name={name} url={url} id={id} selectPoster={selectPoster} />
      </Col>
    )
  );
}  