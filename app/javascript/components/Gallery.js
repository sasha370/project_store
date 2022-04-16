// TODO  I need to learn React and components to be able to use this cards
//  https://mdbootstrap.com/plugins/react/e-commerce-components/

import React from "react"
import ImageGallery from 'react-image-gallery';

class Gallery extends React.Component {
  render() {
    const images = this.props.images;
    return <ImageGallery items={images} showPlayButton={false}/>;
  }
};

export default Gallery;
