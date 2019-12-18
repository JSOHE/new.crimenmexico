import React from 'react';

export default function HeroTitlewithLegend (props) {
  return (
    <React.Fragment>
       {/* <hr className="is-hidden-mobile" /> */}
        <section class="hero">
          <div class="hero-body">
            <div class="container">
              <div className="columns">
                <div className="column is-half">
                  <h1 class="title has-text-right is-size-4-mobile has-text-centered-mobile ">
                    {props.children}
                  </h1>
                  <h2 class="subtitle has-text-right">
                    {' '}
                  </h2>
                </div>
                <div className="column is-half">
                  <p style={{lineHeight: '1.2rem'}}>
                   {props.legend1 && props.legend1 }
                   {props.legend2 && props.legend2}
                   {props.legend3 && props.legend3}
                    
                  </p>
                </div>
              </div>
            </div>
          </div>
        </section>
    </React.Fragment>
  );
}
