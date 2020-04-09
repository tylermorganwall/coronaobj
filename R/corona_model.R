#' SARS-CoV2 Virion 3D Model
#'
#' 3D model of the SARS-CoV2 Virion, sourced from the NIH 3D Print Exchange and created
#' by the National Institute for Allergies and Infectious Diseases (NIAID).
#'
#' Here is a description describing how the model was created, from the NIH site,:
#'
#' "The viral prep used to infect cultured cells (Vero) came from one of the first U.S. patients.
#' Vero cells were infected with SARS-COV-2 for 48 hours, then chemically fixed and embedded in
#' resin for transmission electron microscopy. 150 nanometer resin sections were imaged in a T-12
#' electron microscope and several tilt-series were acquired for 3D reconstruction.
#' Virus particles were segmented from the 3D volumes and analyzed for size,
#' shape, and spike distribution. Multiple transmission electron micrographs
#' indicate virus particles can vary in shape, from flatter discs to somewhat
#' spherical envelopes. The 3D segmentation model of a single viral particle was
#' imported into Maxon C4D, and scaled in a single axis to a representative shape.
#' The C4D Spherify Deformer reduced the visual appearance of “ribs” from the manual
#' segmentation process, and a Shrink Warp Deformer and icosahedron sphere where used to
#' optimize the mesh with evenly distributed polygons. A noise-generated Displacement Deformer
#' added a bumpy, rounded texture to the viral envelope surface. Two spike protein models were
#' imported representing open (PDB 6VSB) and closed states (PDB 6VXX) of a receptor-binding domain.
#'  These were scaled to match the representative spike size from the segmentation model,
#'  and the representative spike then removed. A C4D Cloner with Random and Push Apart
#'  Effectors where used to randomly distribute, rotate, and slightly scale the spike models
#'  in a 1:2 ratio on a smooth hidden inner envelope surface without Displacement.
#'  The model was then exported as FBX to Z-Brush for final optimization and coloring-coding."
#'
#' Model license: CC BY
#' Electron Microscopy Unit, Research Technologies Branch, Rocky Mountain Labs, NIAID
#' Visual & Medical Arts Unit, Research Technologies Branch, Rocky Mountain Labs, NIAID
#' Biovisualization Program, Bioinformatics and Computational Biosciences Branch,
#' Office of Cyber Infrastructure and Computational Biology (OCICB), NIAID
#'
#' @return File location of the SARSCoV2_customcolors.obj file (saved with a .txt extension)
#' @keywords internal
#'
#' @examples
#' #Load and render the SARS Covid-19 model.
#' \donttest{
#' obj_model(corona_model(), y = 0, vertex_colors = TRUE) %>%
#'   render_scene(parallel=TRUE, samples = 10)
#' }
corona_model = function() {
  system.file("extdata", "SARSCoV2_scaled.txt", package="coronaobj")
}
