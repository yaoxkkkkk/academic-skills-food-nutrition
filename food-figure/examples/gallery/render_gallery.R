#!/usr/bin/env Rscript
# Reproducible Figure-story gallery built from synthetic/illustrative data.
# Run from the repository root:
#   Rscript food-figure/examples/gallery/render_gallery.R

root <- "food-figure/examples/gallery"
data_dir <- file.path(root, "data")
figure_dir <- file.path(root, "figures")
dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

set.seed(20260713)
blue <- "#2E73A8"; teal <- "#009E73"; amber <- "#E69F00"
charcoal <- "#333333"; mid_grey <- "#777777"; light_grey <- "#E7E7E7"
palette3 <- c(blue, teal, amber)

panel_tag <- function(tag) mtext(tag, side = 3, adj = 0, line = 0.08,
                                  font = 2, cex = 1.0)

save_pair <- function(stem, draw, width = 2600, height = 3400) {
  pdf_path <- file.path(figure_dir, paste0(stem, ".pdf"))
  png_path <- file.path(figure_dir, paste0(stem, ".png"))
  pdf(pdf_path, width = width / 300, height = height / 300,
      family = "Helvetica", useDingbats = FALSE, bg = "white")
  draw(); dev.off()
  tmp_jpg <- tempfile(fileext = ".jpg")
  status <- system2("sips", c("-s", "format", "jpeg", "-z", as.character(height),
                               as.character(width), pdf_path, "--out", tmp_jpg),
                    stdout = FALSE, stderr = FALSE)
  if (status == 0) status <- system2("sips", c("-s", "format", "png", tmp_jpg,
                                                "--out", png_path),
                                     stdout = FALSE, stderr = FALSE)
  unlink(tmp_jpg)
  if (status != 0 || !file.exists(png_path)) stop("PNG conversion failed for ", stem)
}

story_layout_11 <- function() {
  layout(matrix(c(1, 1, 2,
                  3, 4, 5,
                  6, 7, 8,
                  9, 10, 11), nrow = 4, byrow = TRUE),
         widths = c(1, 1, 1), heights = c(0.82, 1, 1, 1))
  par(oma = c(0.35, 0.35, 2.5, 0.2), family = "sans")
}

story_layout_12 <- function() {
  layout(matrix(seq_len(12), nrow = 4, byrow = TRUE))
  par(oma = c(0.35, 0.35, 2.5, 0.2), family = "sans")
}

base_panel <- function(bottom = 4.0, left = 3.8) {
  par(mar = c(bottom, left, 1.05, 0.45), las = 1,
      cex.axis = 0.62, cex.lab = 0.70)
}

draw_violin <- function(values, groups, labels, cols, ylab, ylim = range(values)) {
  plot(c(0.5, length(labels) + 0.5), ylim, type = "n", xaxt = "n",
       xlab = "", ylab = ylab)
  axis(1, at = seq_along(labels), labels = labels, cex.axis = 0.56)
  for (i in seq_along(labels)) {
    x <- values[groups == labels[i]]; den <- density(x)
    keep <- den$x >= ylim[1] & den$x <= ylim[2]
    den$x <- den$x[keep]; den$y <- den$y[keep]
    scale <- 0.32 * den$y / max(den$y)
    polygon(c(i - scale, rev(i + scale)), c(den$x, rev(den$x)),
            col = adjustcolor(cols[i], 0.22), border = cols[i])
    points(jitter(rep(i, length(x)), amount = 0.06), x, pch = 16, cex = 0.25,
           col = adjustcolor(cols[i], 0.45))
    segments(i - 0.18, median(x), i + 0.18, median(x), lwd = 2, col = cols[i])
  }
}

draw_heatmap <- function(mat, xlabels, ylabels, zlim, digits = 1,
                         low = blue, high = amber, xlab = "") {
  pal <- colorRampPalette(c(low, "white", high))(101)
  image(seq_len(ncol(mat)), seq_len(nrow(mat)), t(mat[nrow(mat):1, ]),
        col = pal, zlim = zlim, axes = FALSE, xlab = xlab, ylab = "")
  axis(1, at = seq_along(xlabels), labels = xlabels, las = 2, cex.axis = 0.48)
  axis(2, at = seq_along(ylabels), labels = rev(ylabels), las = 1, cex.axis = 0.52)
  for (r in seq_len(nrow(mat))) for (c in seq_len(ncol(mat)))
    text(c, nrow(mat) + 1 - r, formatC(mat[r, c], digits = digits, format = "f"), cex = 0.48)
  box()
}

draw_radar <- function(scores, labels, col = amber, footer = "Illustrative integrated profile") {
  n <- length(scores); theta <- seq(0, 2 * pi, length.out = n + 1)[-(n + 1)]
  plot(0, 0, type = "n", xlim = c(-1.28, 1.28), ylim = c(-1.28, 1.28),
       axes = FALSE, xlab = "", ylab = "", asp = 1)
  for (r in c(0.5, 0.8, 1)) lines(r * cos(c(theta, theta[1])),
    r * sin(c(theta, theta[1])), col = if (r == 0.8) mid_grey else light_grey,
    lty = if (r == 0.8) 2 else 1)
  for (i in seq_along(theta)) {
    segments(0, 0, cos(theta[i]), sin(theta[i]), col = light_grey)
    text(1.14 * cos(theta[i]), 1.14 * sin(theta[i]), labels[i], cex = 0.48)
  }
  rr <- c(scores / 100, scores[1] / 100); tt <- c(theta, theta[1])
  polygon(rr * cos(tt), rr * sin(tt), border = col, col = adjustcolor(col, 0.18), lwd = 2)
  points((scores / 100) * cos(theta), (scores / 100) * sin(theta), pch = 16, col = col, cex = 0.55)
  text(0, -1.20, footer, cex = 0.48, col = mid_grey)
}

line_summary <- function(data, x, y, group, cols, xlab, ylab, ylim = range(data[[y]])) {
  lev <- unique(data[[group]])
  plot(range(data[[x]]), ylim, type = "n", xlab = xlab, ylab = ylab)
  for (i in seq_along(lev)) {
    d <- data[data[[group]] == lev[i], ]; means <- tapply(d[[y]], d[[x]], mean)
    sds <- tapply(d[[y]], d[[x]], sd); xx <- as.numeric(names(means))
    arrows(xx, means - sds, xx, means + sds, angle = 90, code = 3,
           length = 0.025, col = cols[i])
    lines(xx, means, type = "b", pch = 14 + i, lwd = 1.7, col = cols[i])
  }
  legend("bottomleft", lev, col = cols, lwd = 1.6, pch = 15 + seq_along(lev),
         bty = "n", cex = 0.48)
}

# -----------------------------------------------------------------------------
# Case 1: active packaging. Material properties lead into storage performance.

packages <- c("Control", "Pectin", "Active pectin")
storage <- expand.grid(package = packages, day = c(0, 7, 14, 21), replicate = 1:8,
                       KEEP.OUT.ATTRS = FALSE, stringsAsFactors = FALSE)
pkg_effect <- c("Control" = 0, "Pectin" = 0.9, "Active pectin" = 2.2)
storage$polyphenol_retention_percent <- 100 - (2.55 - 0.55 * pkg_effect[storage$package]) * storage$day + rnorm(nrow(storage), 0, 2.2)
storage$weight_loss_percent <- (0.34 - 0.065 * pkg_effect[storage$package]) * storage$day + rnorm(nrow(storage), 0, 0.35)
storage$delta_E <- (0.30 - 0.055 * pkg_effect[storage$package]) * storage$day + rnorm(nrow(storage), 0, 0.38)
storage$headspace_oxygen_percent <- 20.9 - (0.25 + 0.14 * pkg_effect[storage$package]) * storage$day + rnorm(nrow(storage), 0, 0.35)
write.csv(storage, file.path(data_dir, "active_packaging_storage.csv"), row.names = FALSE)

material <- expand.grid(package = packages, strain_percent = seq(0, 45, by = 3), replicate = 1:3,
                        KEEP.OUT.ATTRS = FALSE, stringsAsFactors = FALSE)
strength <- c("Control" = 0.16, "Pectin" = 0.30, "Active pectin" = 0.27)
material$stress_MPa <- pmax(0, strength[material$package] * material$strain_percent *
  exp(-material$strain_percent / c("Control" = 26, "Pectin" = 34, "Active pectin" = 38)[material$package]) + rnorm(nrow(material), 0, 0.08))
material$water_vapour_permeability_g_mm_m2_day_kPa <- c("Control" = 5.8, "Pectin" = 3.9, "Active pectin" = 3.1)[material$package] + rnorm(nrow(material), 0, 0.20)
write.csv(material, file.path(data_dir, "active_packaging_material.csv"), row.names = FALSE)

dose <- expand.grid(concentration_mg_mL = c(0.05, 0.1, 0.25, 0.5, 1, 2), replicate = 1:5)
dose$radical_scavenging_percent <- 7 + 84 * dose$concentration_mg_mL /
  (0.42 + dose$concentration_mg_mL) + rnorm(nrow(dose), 0, 2.5)
write.csv(dose, file.path(data_dir, "active_packaging_dose_response.csv"), row.names = FALSE)

draw_active <- function() {
  story_layout_11()
  par(mar = c(0.5, 0.5, 1.05, 0.5)); plot(c(0, 12), c(0, 4), type = "n", axes = FALSE, xlab = "", ylab = "")
  rect(0.3, 1.25, 2.2, 2.75, border = blue, lwd = 2, col = adjustcolor(blue, 0.08)); text(1.25, 2.2, "Pectin film", font = 2, cex = 0.75); text(1.25, 1.7, "+ plant extract", cex = 0.65)
  arrows(2.3, 2, 3.0, 2, length = 0.08); rect(3.1, 1.0, 5.2, 3.0, border = teal, lwd = 2); text(4.15, 2.35, "Film tests", font = 2, cex = 0.74); text(4.15, 1.75, "mechanics | barrier", cex = 0.62)
  arrows(5.3, 2, 6.0, 2, length = 0.08); rect(6.1, 1.0, 8.3, 3.0, border = amber, lwd = 2, col = adjustcolor(amber, 0.08)); text(7.2, 2.35, "Blueberries", font = 2, cex = 0.74); text(7.2, 1.75, "0-21 d chilled", cex = 0.62)
  arrows(8.4, 2, 9.1, 2, length = 0.08); rect(9.2, 1.0, 11.7, 3.0, border = charcoal, lwd = 2); text(10.45, 2.35, "Quality outcomes", font = 2, cex = 0.72); text(10.45, 1.75, "retention | loss | colour", cex = 0.58); panel_tag("a")

  base_panel(); line_summary(material, "strain_percent", "stress_MPa", "package", palette3,
    "Strain (%)", "Stress (MPa)"); panel_tag("b")
  base_panel(4.0, 4.0); wvp <- tapply(material$water_vapour_permeability_g_mm_m2_day_kPa, material$package, mean)[packages]; wsd <- tapply(material$water_vapour_permeability_g_mm_m2_day_kPa, material$package, sd)[packages]
  mids <- barplot(wvp, col = palette3, border = NA, names.arg = c("Control", "Pectin", "Active"), ylab = "WVP (g mm m-2 day-1 kPa-1)", cex.names = 0.52, ylim = c(0, 6.8)); arrows(mids, wvp-wsd, mids, wvp+wsd, angle=90, code=3, length=.03); panel_tag("c")
  base_panel(); line_summary(storage, "day", "polyphenol_retention_percent", "package", palette3, "Storage day", "Polyphenol retention (%)", c(45, 105)); panel_tag("d")
  base_panel(); line_summary(storage, "day", "weight_loss_percent", "package", palette3, "Storage day", "Weight loss (%)", c(0, 9)); panel_tag("e")
  base_panel(); end <- storage[storage$day == 21, ]; draw_violin(end$polyphenol_retention_percent, end$package, packages, palette3, "Day-21 retention (%)", c(45, 85)); panel_tag("f")
  base_panel(); draw_violin(end$delta_E, end$package, packages, palette3, "Day-21 colour change (Delta E)", c(2, 9)); panel_tag("g")
  base_panel(); m <- tapply(dose$radical_scavenging_percent, dose$concentration_mg_mL, mean); x <- as.numeric(names(m)); plot(x,m,log="x",pch=16,col=teal,xlab="Extract concentration (mg/mL)",ylab="Radical scavenging (%)",ylim=c(0,100)); fit<-smooth.spline(log10(x),m,spar=.65); xx<-seq(log10(min(x)),log10(max(x)),length.out=100); lines(10^xx,predict(fit,xx)$y,col=teal,lwd=2); panel_tag("h")
  base_panel(5.0, 3.6); corr <- cor(storage[c("polyphenol_retention_percent","weight_loss_percent","delta_E","headspace_oxygen_percent")]); colnames(corr)<-rownames(corr)<-c("Retention","Weight loss","Delta E","Oxygen"); draw_heatmap(corr,colnames(corr),rownames(corr),c(-1,1),2,xlab="Quality marker"); panel_tag("i")
  base_panel(); pca <- prcomp(scale(storage[c("polyphenol_retention_percent","weight_loss_percent","delta_E","headspace_oxygen_percent")])); plot(pca$x[,1:2],pch=16,col=adjustcolor(palette3[match(storage$package,packages)],.45),xlab="PC1 score",ylab="PC2 score"); legend("topright",packages,col=palette3,pch=16,bty="n",cex=.45); panel_tag("j")
  par(mar=c(.7,.7,1.05,.7)); active_scores<-c(Barrier=91,Mechanics=86,Retention=93,Appearance=88,Antioxidant=90); draw_radar(active_scores,names(active_scores),teal,"Illustrative package-performance profile"); panel_tag("k")
  mtext("Figure 1 | Active pectin packaging links film function to blueberry quality retention", side=3,outer=TRUE,adj=0,line=.55,font=2,cex=1.08)
}

# -----------------------------------------------------------------------------
# Case 2: probiotic encapsulation. Process leads into survival and robustness.

probiotic <- expand.grid(treatment=c("Free cells","Encapsulated"), day=c(0,7,14,21,28), batch=paste0("B",1:8), replicate=1:3, KEEP.OUT.ATTRS=FALSE, stringsAsFactors=FALSE)
rate <- c("Free cells"=.098,"Encapsulated"=.052)
batch_shift <- setNames(rnorm(8,0,.10),paste0("B",1:8))
probiotic$log_CFU_g <- 8.65 - rate[probiotic$treatment]*probiotic$day + batch_shift[probiotic$batch] + rnorm(nrow(probiotic),0,.12)
write.csv(probiotic,file.path(data_dir,"probiotic_storage_kinetics.csv"),row.names=FALSE)

challenge <- expand.grid(treatment=c("Free cells","Encapsulated"), challenge=c("Acid pH 2.5","Bile 0.3%"), exposure_min=c(0,30,60,90), batch=paste0("B",1:8), KEEP.OUT.ATTRS=FALSE, stringsAsFactors=FALSE)
challenge_rate <- ifelse(challenge$challenge=="Acid pH 2.5",.020,.014) * ifelse(challenge$treatment=="Encapsulated",.55,1)
challenge$log_CFU_mL <- 8.2-challenge_rate*challenge$exposure_min+rnorm(nrow(challenge),0,.13)
write.csv(challenge,file.path(data_dir,"probiotic_challenge_survival.csv"),row.names=FALSE)

encap <- data.frame(batch=paste0("B",1:8), encapsulation_efficiency_percent=rnorm(8,91,2), bead_diameter_um=rnorm(8,620,35))
write.csv(encap,file.path(data_dir,"probiotic_encapsulation_properties.csv"),row.names=FALSE)

draw_probiotic <- function(){
  story_layout_11()
  par(mar=c(.5,.5,1.05,.5)); plot(c(0,12),c(0,4),type="n",axes=FALSE,xlab="",ylab=""); rect(.3,1.2,2.2,2.8,border=blue,lwd=2); text(1.25,2.25,"Culture",font=2,cex=.75); text(1.25,1.7,"same inoculum",cex=.62); arrows(2.3,2,3.0,2,length=.08); rect(3.1,.8,5.2,3.2,border=teal,lwd=2,col=adjustcolor(teal,.07)); text(4.15,2.55,"Formulation",font=2,cex=.72); text(4.15,2,"free cells",cex=.62); text(4.15,1.45,"alginate beads",cex=.62); arrows(5.3,2,6,2,length=.08); rect(6.1,1,8.3,3,border=amber,lwd=2); text(7.2,2.35,"Chilled storage",font=2,cex=.72); text(7.2,1.75,"0-28 d | 8 batches",cex=.60); arrows(8.4,2,9.1,2,length=.08); rect(9.2,1,11.7,3,border=charcoal,lwd=2); text(10.45,2.35,"Performance",font=2,cex=.72); text(10.45,1.75,"survival | challenge",cex=.60); panel_tag("a")
  base_panel(); line_summary(probiotic,"day","log_CFU_g","treatment",c(blue,teal),"Storage day","Viable count (log CFU/g)",c(5.5,9)); abline(h=6,lty=2,col=mid_grey); panel_tag("b")
  fitp<-lm(log_CFU_g~day*treatment,data=probiotic); probiotic$residual<-resid(fitp); base_panel(); plot(fitted(fitp),resid(fitp),pch=16,col=adjustcolor(ifelse(probiotic$treatment=="Free cells",blue,teal),.45),xlab="Fitted viable count",ylab="Model residual"); abline(h=0,lty=2,col=mid_grey); panel_tag("c")
  base_panel(); pend<-probiotic[probiotic$day==28,]; draw_violin(pend$log_CFU_g,pend$treatment,c("Free cells","Encapsulated"),c(blue,teal),"Day-28 viable count (log CFU/g)",c(5.5,8)); panel_tag("d")
  base_panel(); loss<-aggregate(log_CFU_g~treatment+batch,probiotic[probiotic$day %in% c(0,28),],function(x)x[1]-x[length(x)]); draw_violin(loss$log_CFU_g,loss$treatment,c("Free cells","Encapsulated"),c(blue,teal),"28-day loss (log CFU/g)",c(0,3.2)); panel_tag("e")
  base_panel(); acid<-challenge[challenge$challenge=="Acid pH 2.5",]; line_summary(acid,"exposure_min","log_CFU_mL","treatment",c(blue,teal),"Acid exposure (min)","Viable count (log CFU/mL)",c(6,8.5)); panel_tag("f")
  base_panel(); bile<-challenge[challenge$challenge=="Bile 0.3%" & challenge$exposure_min==90,]; draw_violin(bile$log_CFU_mL,bile$treatment,c("Free cells","Encapsulated"),c(blue,teal),"After 90 min bile challenge",c(6.2,8)); panel_tag("g")
  base_panel(); barplot(encap$encapsulation_efficiency_percent,names.arg=encap$batch,col=teal,border=NA,ylim=c(0,100),ylab="Encapsulation efficiency (%)",cex.names=.48); panel_tag("h")
  base_panel(4.0,4.4); batch_rates<-sapply(paste0("B",1:8),function(b){d<-probiotic[probiotic$batch==b & probiotic$treatment=="Encapsulated",]; -coef(lm(log_CFU_g~day,d))[2]}); se<-rep(.006,8); y<-rev(1:8); plot(c(.02,.08),c(.5,8.5),type="n",yaxt="n",xlab="Decay rate (log CFU/g/day)",ylab=""); axis(2,at=y,labels=paste0("Batch ",1:8),las=1,cex.axis=.48); arrows(batch_rates-1.96*se,y,batch_rates+1.96*se,y,angle=90,code=3,length=.025,col=teal); points(batch_rates,y,pch=15,col=teal); abline(v=mean(batch_rates),lty=2,col=mid_grey); panel_tag("i")
  base_panel(5.0,3.6); robust<-outer(c(4,8,12),c("Milk"=0,"Juice"=-.35,"Yogurt"=.18),function(temp,matrix)7.6-.055*(temp-4)+matrix); rownames(robust)<-paste(c(4,8,12),"C"); draw_heatmap(robust,colnames(robust),rownames(robust),c(6.8,7.9),2,blue,amber,"Food matrix"); panel_tag("j")
  par(mar=c(.7,.7,1.05,.7)); scores<-c(Storage=91,Acid=88,Bile=90,Efficiency=93,Batch=85); draw_radar(scores,names(scores),teal,"Illustrative probiotic-performance profile"); panel_tag("k")
  mtext("Figure 2 | Encapsulation improves probiotic survival across storage and challenge conditions",side=3,outer=TRUE,adj=0,line=.55,font=2,cex=1.05)
}

# -----------------------------------------------------------------------------
# Case 3: sensory study. Panel design leads into discrimination and preference.

attributes<-c("Berry aroma","Sweetness","Sourness","Creaminess","Aftertaste")
products<-c("Plain","Berry-low","Berry-high")
sensory<-expand.grid(panelist=sprintf("P%02d",1:24),product=products,session=1:2,attribute=attributes,KEEP.OUT.ATTRS=FALSE,stringsAsFactors=FALSE)
base_attr<-c("Berry aroma"=2.2,"Sweetness"=4.8,"Sourness"=4.5,"Creaminess"=5.8,"Aftertaste"=3.5)
prod_shift<-matrix(c(0,0,0,0,0, 2.1,.7,-.2,.1,.8, 4.0,1.4,-.5,-.2,1.5),nrow=3,byrow=TRUE,dimnames=list(products,attributes))
panel_shift<-setNames(rnorm(24,0,.35),sprintf("P%02d",1:24))
sensory$score<-pmin(9,pmax(0,base_attr[sensory$attribute]+prod_shift[cbind(sensory$product,sensory$attribute)]+panel_shift[sensory$panelist]+rnorm(nrow(sensory),0,.65)))
liking<-expand.grid(panelist=sprintf("P%02d",1:24),product=products,session=1:2,KEEP.OUT.ATTRS=FALSE,stringsAsFactors=FALSE)
liking$overall_liking<-pmin(9,pmax(1,c("Plain"=5.1,"Berry-low"=6.6,"Berry-high"=6.0)[liking$product]+rnorm(nrow(liking),0,.85)))
write.csv(sensory,file.path(data_dir,"sensory_panel_ratings.csv"),row.names=FALSE); write.csv(liking,file.path(data_dir,"sensory_overall_liking.csv"),row.names=FALSE)

draw_sensory <- function(){
  story_layout_11()
  par(mar=c(.5,.5,1.05,.5)); plot(c(0,12),c(0,4),type="n",axes=FALSE,xlab="",ylab=""); rect(.3,1.1,2.2,2.9,border=blue,lwd=2); text(1.25,2.35,"24 panelists",font=2,cex=.75); text(1.25,1.75,"2 sessions",cex=.62); arrows(2.3,2,3,2,length=.08); rect(3.1,.9,5.2,3.1,border=teal,lwd=2); text(4.15,2.45,"Blind tasting",font=2,cex=.72); text(4.15,1.9,"3 coded yogurts",cex=.62); text(4.15,1.45,"random order",cex=.62); arrows(5.3,2,6,2,length=.08); rect(6.1,.9,8.3,3.1,border=amber,lwd=2,col=adjustcolor(amber,.07)); text(7.2,2.45,"Responses",font=2,cex=.72); text(7.2,1.9,"5 attributes",cex=.62); text(7.2,1.45,"overall liking",cex=.62); arrows(8.4,2,9.1,2,length=.08); rect(9.2,.9,11.7,3.1,border=charcoal,lwd=2); text(10.45,2.45,"Interpretation",font=2,cex=.72); text(10.45,1.9,"PCA | drivers",cex=.62); panel_tag("a")
  means<-aggregate(score~product+attribute,sensory,mean); par(mar=c(.7,.7,1.05,.7)); n<-length(attributes); th<-seq(0,2*pi,length.out=n+1)[-(n+1)]; plot(0,0,type="n",xlim=c(-1.25,1.25),ylim=c(-1.25,1.25),axes=FALSE,xlab="",ylab="",asp=1); for(r in c(3,6,9))lines(r/9*cos(c(th,th[1])),r/9*sin(c(th,th[1])),col=light_grey); for(i in 1:n){segments(0,0,cos(th[i]),sin(th[i]),col=light_grey);text(1.14*cos(th[i]),1.14*sin(th[i]),attributes[i],cex=.42)}; for(i in 1:3){d<-means[means$product==products[i],];d<-d[match(attributes,d$attribute),];rr<-c(d$score/9,d$score[1]/9);lines(rr*cos(c(th,th[1])),rr*sin(c(th,th[1])),col=palette3[i],lwd=1.6)}; legend("topright",products,col=palette3,lwd=1.6,bty="n",cex=.42);panel_tag("b")
  base_panel(5.0,3.8); berry<-sensory[sensory$attribute=="Berry aroma",]; draw_violin(berry$score,berry$product,products,palette3,"Berry-aroma intensity (0-9)",c(0,9)); panel_tag("c")
  base_panel(); draw_violin(liking$overall_liking,liking$product,products,palette3,"Overall liking (0-9)",c(1,9)); panel_tag("d")
  wide<-reshape(aggregate(score~panelist+product+attribute,sensory,mean),idvar=c("panelist","product"),timevar="attribute",direction="wide"); X<-wide[grep("score",names(wide))]; pc<-prcomp(X,scale.=TRUE); pcols<-palette3[match(wide$product,products)]; base_panel(); plot(pc$x[,1],pc$x[,2],pch=16,col=adjustcolor(pcols,.55),xlab="PC1 score",ylab="PC2 score"); legend("topright",products,col=palette3,pch=16,bty="n",cex=.42); panel_tag("e")
  base_panel(); load<-pc$rotation[,1:2]; plot(load[,1],load[,2],type="n",xlim=range(c(0,load[,1]))*1.2,ylim=range(c(0,load[,2]))*1.2,xlab="PC1 loading",ylab="PC2 loading"); arrows(0,0,load[,1],load[,2],length=.07,col=amber); text(load[,1],load[,2],sub("score.","",rownames(load),fixed=TRUE),cex=.43,pos=3); abline(h=0,v=0,col=light_grey); panel_tag("f")
  repeatability<-matrix(NA,24,5,dimnames=list(sprintf("P%02d",1:24),attributes)); for(p in rownames(repeatability))for(a in attributes){d<-sensory[sensory$panelist==p & sensory$attribute==a,];repeatability[p,a]<-mean(abs(d$score[d$session==1]-d$score[d$session==2]))}; base_panel(5.0,3.4); draw_heatmap(repeatability[1:8,],attributes,paste0("P",sprintf("%02d",1:8)),c(0,2.5),1,"white",amber,"Attribute"); panel_tag("g")
  fstats<-sapply(attributes,function(a)summary(aov(score~product,sensory[sensory$attribute==a,]))[[1]][1,"F value"]); base_panel(4.0,4.7); yy<-rev(seq_along(fstats)); plot(c(0,max(fstats)*1.15),c(.5,5.5),type="n",yaxt="n",xlab="Illustrative product F statistic",ylab="");axis(2,at=yy,labels=attributes,las=1,cex.axis=.48);segments(0,yy,fstats,yy,col=teal,lwd=3);points(fstats,yy,pch=16,col=teal);panel_tag("h")
  like_mean<-aggregate(overall_liking~panelist+product,liking,mean); pref<-reshape(like_mean,idvar="panelist",timevar="product",direction="wide"); base_panel(); plot(pref[["overall_liking.Berry-low"]],pref[["overall_liking.Berry-high"]],pch=16,col=adjustcolor(amber,.6),xlab="Liking: berry-low",ylab="Liking: berry-high");abline(a=0,b=1,lty=2,col=mid_grey);panel_tag("i")
  base_panel(4.0,4.7); penalty<-c("Too little berry"=-.8,"Too sour"=-1.1,"Too sweet"=-.6,"Weak creaminess"=-.5); barplot(penalty,horiz=TRUE,col=amber,border=NA,xlim=c(-1.4,0),xlab="Illustrative liking penalty",las=1,cex.names=.48);abline(v=0,col=mid_grey);panel_tag("j")
  par(mar=c(.7,.7,1.05,.7)); ss<-c(Discrimination=92,Repeatability=84,Liking=88,PCA=86,Actionability=89);draw_radar(ss,names(ss),amber,"Illustrative sensory-study profile");panel_tag("k")
  mtext("Figure 3 | Trained-panel profiling resolves yogurt sensory drivers and preference",side=3,outer=TRUE,adj=0,line=.55,font=2,cex=1.06)
}

# -----------------------------------------------------------------------------
# Case 4: method validation. Design, response, calibration, agreement,
# diagnostics, accuracy, precision, robustness, and synthesis.

n_samples<-72
pairs<-data.frame(sample_id=sprintf("S%02d",1:n_samples),matrix=rep(c("Berry puree","Juice","Yogurt"),length.out=n_samples),operator=rep(c("Operator A","Operator B","Operator C"),each=24),day=rep(1:3,each=8,times=3),stringsAsFactors=FALSE)
matrix_shift<-c("Berry puree"=10,"Juice"=-4,"Yogurt"=3);operator_bias<-c("Operator A"=-.8,"Operator B"=.4,"Operator C"=1.1)
pairs$hplc_mg_GAE_100g_wb<-seq(25,135,length.out=n_samples)+matrix_shift[pairs$matrix]+rnorm(n_samples,0,2.2)
pairs$rapid_mg_GAE_100g_wb<-1.8+.982*pairs$hplc_mg_GAE_100g_wb+operator_bias[pairs$operator]+rnorm(n_samples,0,2.8)
pairs$concentration_band<-cut(pairs$hplc_mg_GAE_100g_wb,breaks=c(-Inf,65,100,Inf),labels=c("Low","Medium","High"));write.csv(pairs,file.path(data_dir,"method_paired_measurements.csv"),row.names=FALSE)
calibration<-expand.grid(standard_mg_GAE_L=c(0,20,40,60,80,100),analytical_replicate=1:4);calibration$absorbance_765nm<-.035+.0082*calibration$standard_mg_GAE_L+rnorm(nrow(calibration),0,.012);write.csv(calibration,file.path(data_dir,"method_calibration_standards.csv"),row.names=FALSE)
signal<-expand.grid(reaction_time_min=seq(0,10,by=.5),standard_mg_GAE_L=c(25,50,100));signal$absorbance_765nm<-.03+(.0025+.0078*signal$standard_mg_GAE_L)*(1-exp(-.48*signal$reaction_time_min))+rnorm(nrow(signal),0,.008);write.csv(signal,file.path(data_dir,"method_reaction_profiles.csv"),row.names=FALSE)
recovery<-expand.grid(spike_level_mg_GAE_100g=c(25,50,100),operator=c("Operator A","Operator B","Operator C"),day=1:3,analytical_replicate=1:3,stringsAsFactors=FALSE);recovery$recovery_percent<-99.5+c("Operator A"=-.5,"Operator B"=.2,"Operator C"=.7)[recovery$operator]+rnorm(nrow(recovery),0,1.25);write.csv(recovery,file.path(data_dir,"method_recovery_precision.csv"),row.names=FALSE)
robustness<-expand.grid(operator=c("Operator A","Operator B","Operator C"),condition=c("Time -20%","Nominal","Time +20%","pH -0.2","pH +0.2"),stringsAsFactors=FALSE);cb<-c("Time -20%"=-1.8,"Nominal"=0,"Time +20%"=1.2,"pH -0.2"=-1.1,"pH +0.2"=1.5);robustness$relative_bias_percent<-cb[robustness$condition]+.45*operator_bias[robustness$operator]+rnorm(nrow(robustness),0,.35);write.csv(robustness,file.path(data_dir,"method_robustness_matrix.csv"),row.names=FALSE)

draw_method <- function(){
  story_layout_12()
  par(mar=c(.5,.5,1.05,.5));plot(c(0,10),c(0,4),type="n",axes=FALSE,xlab="",ylab="");rect(.2,1.2,1.9,2.8,border=blue,lwd=2);text(1.05,2.35,"Food\nsamples",font=2,cex=.55);text(1.05,1.62,"3 matrices",cex=.52);arrows(2,2,2.6,2,length=.07);rect(2.7,2.2,4.4,3.2,border=blue,lwd=2);rect(2.7,.8,4.4,1.8,border=amber,lwd=2);text(3.55,2.7,"HPLC",font=2,cex=.65);text(3.55,1.3,"Rapid assay",font=2,cex=.58);arrows(4.5,2.7,5.2,2.25,length=.07);arrows(4.5,1.3,5.2,1.75,length=.07);rect(5.3,1,7.4,3,border=teal,lwd=2);text(6.35,2.4,"Validation",font=2,cex=.68);text(6.35,1.8,"agreement | recovery",cex=.48);text(6.35,1.35,"precision | robustness",cex=.48);arrows(7.5,2,8.1,2,length=.07);rect(8.2,1.2,9.8,2.8,border=charcoal,lwd=2,col=adjustcolor(amber,.08));text(9,2.2,"Decision",font=2,cex=.64);text(9,1.65,"illustrative",cex=.52);panel_tag("a")
  base_panel();sl<-c(25,50,100);plot(range(signal$reaction_time_min),range(signal$absorbance_765nm),type="n",xlab="Reaction time (min)",ylab="Absorbance (765 nm)");for(i in 1:3){d<-signal[signal$standard_mg_GAE_L==sl[i],];lines(d$reaction_time_min,d$absorbance_765nm,col=palette3[i],lwd=1.6)};legend("bottomright",paste(sl,"mg GAE/L"),col=palette3,lwd=1.6,bty="n",cex=.42);panel_tag("b")
  base_panel(4.8,3.8);vals<-c(pairs$hplc_mg_GAE_100g_wb,pairs$rapid_mg_GAE_100g_wb);grp<-interaction(rep(pairs$concentration_band,2),rep(c("HPLC","Rapid"),each=nrow(pairs)),lex.order=TRUE);boxplot(vals~grp,names=c("Low\nHPLC","Low\nRapid","Mid\nHPLC","Mid\nRapid","High\nHPLC","High\nRapid"),col=rep(c(adjustcolor(blue,.2),adjustcolor(amber,.2)),3),border=rep(c(blue,amber),3),ylab="Phenolics (mg GAE/100 g)",xlab="",cex.axis=.45);panel_tag("c")
  base_panel();cm<-lm(absorbance_765nm~standard_mg_GAE_L,calibration);plot(calibration$standard_mg_GAE_L,calibration$absorbance_765nm,pch=16,col=adjustcolor(teal,.55),xlab="Standard (mg GAE/L)",ylab="Absorbance (765 nm)");abline(cm,col=teal,lwd=2);legend("topleft",sprintf("Illustrative R2 = %.3f",summary(cm)$r.squared),bty="n",cex=.48);panel_tag("d")
  model<-lm(rapid_mg_GAE_100g_wb~hplc_mg_GAE_100g_wb,pairs);base_panel();plot(pairs$hplc_mg_GAE_100g_wb,pairs$rapid_mg_GAE_100g_wb,pch=16,col=adjustcolor(blue,.6),xlab="HPLC (mg GAE/100 g)",ylab="Rapid assay (mg GAE/100 g)");abline(0,1,lty=2,col=mid_grey);abline(model,col=amber,lwd=2);panel_tag("e")
  base_panel();plot(fitted(model),resid(model),pch=16,col=adjustcolor(blue,.55),xlab="Fitted rapid-assay value",ylab="Regression residual");abline(h=0,lty=2,col=mid_grey);lines(lowess(fitted(model),resid(model)),col=amber,lwd=1.6);panel_tag("f")
  pairs$mean<-rowMeans(pairs[c("hplc_mg_GAE_100g_wb","rapid_mg_GAE_100g_wb")]);pairs$diff<-pairs$rapid_mg_GAE_100g_wb-pairs$hplc_mg_GAE_100g_wb;bias<-mean(pairs$diff);loa<-bias+c(-1.96,1.96)*sd(pairs$diff);base_panel();plot(pairs$mean,pairs$diff,pch=16,col=adjustcolor(amber,.65),xlab="Mean of methods (mg GAE/100 g)",ylab="Rapid - HPLC");abline(h=bias,col=charcoal,lwd=1.4);abline(h=loa,lty=2,col=mid_grey);panel_tag("g")
  base_panel();rmn<-tapply(recovery$recovery_percent,recovery$spike_level_mg_GAE_100g,mean);rsd<-tapply(recovery$recovery_percent,recovery$spike_level_mg_GAE_100g,sd);mids<-barplot(rmn,names.arg=paste(names(rmn),"mg"),col=teal,border=NA,ylim=c(0,107),ylab="Recovery (%)",cex.names=.50);arrows(mids,rmn-rsd,mids,rmn+rsd,angle=90,code=3,length=.03);abline(h=100,lty=2,col=mid_grey);panel_tag("h")
  base_panel();recovery$error<-recovery$recovery_percent-100;draw_violin(recovery$error,recovery$operator,c("Operator A","Operator B","Operator C"),palette3,"Recovery error (percentage points)",c(-4,4));abline(h=0,lty=2,col=mid_grey);panel_tag("i")
  base_panel(5.0,3.6);ops<-c("Operator A","Operator B","Operator C");conds<-c("Time -20%","Nominal","Time +20%","pH -0.2","pH +0.2");mat<-matrix(NA,3,5,dimnames=list(c("A","B","C"),conds));for(r in 1:nrow(robustness))mat[match(robustness$operator[r],ops),match(robustness$condition[r],conds)]<-robustness$relative_bias_percent[r];draw_heatmap(mat,conds,c("A","B","C"),c(-3,3),1,blue,amber,"Perturbation");panel_tag("j")
  base_panel(4.0,3.8);contrib<-c(Linearity=18,Agreement=16,Recovery=17,Precision=15,Robustness=14);start<-c(0,cumsum(contrib)[-length(contrib)]);end<-cumsum(contrib);plot(c(0,6),c(0,85),type="n",xaxt="n",xlab="Validation component",ylab="Cumulative illustrative score");for(i in 1:5){rect(i-.35,start[i],i+.35,end[i],col=palette3[(i-1)%%3+1],border=NA);if(i<5)segments(i+.35,end[i],i+1-.35,end[i],lty=2,col=mid_grey)};axis(1,at=1:5,labels=names(contrib),las=2,cex.axis=.45);points(5.8,sum(contrib),pch=18,cex=1.3,col=charcoal);text(5.8,sum(contrib)+4,"Integrated",cex=.45);panel_tag("k")
  par(mar=c(.7,.7,1.05,.7));scores<-c(Linearity=99,Agreement=93,Recovery=98,Precision=92,Robustness=90);draw_radar(scores,names(scores),amber,"Illustrative validation profile");panel_tag("l")
  mtext("Figure 4 | Integrated validation supports a rapid phenolic assay across matrices",side=3,outer=TRUE,adj=0,line=.55,font=2,cex=1.06)
}

save_pair("fig1_active_packaging", draw_active)
save_pair("fig2_probiotic_storage_kinetics", draw_probiotic)
save_pair("fig3_sensory_radar", draw_sensory)
save_pair("fig4_method_validation_and_evidence", draw_method)
message("Wrote four final Figure-story PDF and PNG pairs to ", figure_dir)
